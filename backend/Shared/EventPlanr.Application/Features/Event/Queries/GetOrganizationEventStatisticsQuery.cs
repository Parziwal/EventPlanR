using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Ticket;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Queries;

[Authorize(OrganizationPolicy = OrganizationPolicies.EventStatistics)]
public class GetOrganizationEventStatisticsQuery : IRequest<EventStatisticsDto>
{
    public Guid EventId { get; set; }
}

public class GetOrganizationEventStatisticsQueryHandler : IRequestHandler<GetOrganizationEventStatisticsQuery, EventStatisticsDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public GetOrganizationEventStatisticsQueryHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task<EventStatisticsDto> Handle(GetOrganizationEventStatisticsQuery request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .Include(e => e.Tickets)
                .ThenInclude(t => t.SoldTickets)
                    .ThenInclude(st => st.Order)
            .Include(e => e.Invitations)
            .SingleEntityAsync(e => e.Id == request.EventId && e.OrganizationId == _user.OrganizationId);

        var ticketStatistics = eventEntity.Tickets
            .Select(t => new TicketStatisticsDto()
            {
                Id = t.Id,
                TicketName = t.Name,
                TotalTicketCount = t.Count,
                SoldTicketCount = t.Count - t.RemainingCount,
                CheckedInTicketCount = t.SoldTickets.Where(st => st.IsCheckedIn).Count(),
            })
            .ToList();

        return new EventStatisticsDto()
        {
            TotalIncome = eventEntity.Tickets.SelectMany(t => t.SoldTickets).Sum(st => st.Price),
            Currency = eventEntity.Currency,
            TotalTicketCount = eventEntity.Tickets.Sum(t => t.Count),
            SoldTicketCount = eventEntity.Tickets.Sum(t => t.Count - t.RemainingCount),
            SoldTicketsPerDay = GetSoldTicketsPerDay(eventEntity),
            SoldTicketsPerMonth = GetSoldTicketsPerMonth(eventEntity),
            TicketStatistics = ticketStatistics,
            TotalCheckInCount = eventEntity.Tickets.SelectMany(t => t.SoldTickets).Where(st => st.IsCheckedIn).Count(),
            CheckInsPerHour = GetCheckedInTicketsPerHour(eventEntity),
            CheckInsPerDay = GetCheckedInTicketsPerDay(eventEntity),
            TotalInvitationCount = eventEntity.Invitations.Count(),
            AcceptedInvitationCount = eventEntity.Invitations.Where(i => i.Status == InvitationStatus.Accept).Count(),
            DeniedInvitationCount = eventEntity.Invitations.Where(i => i.Status == InvitationStatus.Deny).Count(),
            PendingInvitationCount = eventEntity.Invitations.Where(i => i.Status == InvitationStatus.Pending).Count(),
        };
    }

    private List<ChartSpotDto> GetSoldTicketsPerDay(EventEntity eventEntity)
    {
        var soldTicketPerDay = eventEntity.Tickets.SelectMany(t => t.SoldTickets)
            .OrderBy(st => st.Order.Created)
            .GroupBy(st => new { st.Order.Created.Year, st.Order.Created.Month, st.Order.Created.Day })
            .Select(st => new ChartSpotDto()
            {
                DateTime = new DateTime(st.Key.Year, st.Key.Month, st.Key.Day),
                Count = st.Count(),
            })
            .ToList();

        var timeNow = DateTimeOffset.UtcNow;
        var startDate = new DateTime(eventEntity.FromDate.Year, eventEntity.FromDate.Month, eventEntity.FromDate.Day);
        var endDate = eventEntity.ToDate > timeNow
            ? new DateTime(timeNow.Year, timeNow.Month, timeNow.Day)
            : new DateTime(eventEntity.ToDate.Year, eventEntity.ToDate.Month, eventEntity.ToDate.Day);
        foreach (var day in startDate.EachDayUntil(endDate))
        {
            if (!soldTicketPerDay.Any(st => st.DateTime == day))
            {
                soldTicketPerDay.Add(new ChartSpotDto()
                {
                    DateTime = day,
                    Count = 0,
                });
            }
        }
        
        return soldTicketPerDay.OrderBy(st => st.DateTime).ToList();
    }

    private List<ChartSpotDto> GetSoldTicketsPerMonth(EventEntity eventEntity)
    {
        var soldTicketPerMonth = eventEntity.Tickets.SelectMany(t => t.SoldTickets)
            .OrderBy(st => st.Order.Created)
            .GroupBy(st => new { st.Order.Created.Year, st.Order.Created.Month })
            .Select(st => new ChartSpotDto()
            {
                DateTime = new DateTime(st.Key.Year, st.Key.Month, 1),
                Count = st.Count(),
            })
            .ToList();

        var timeNow = DateTimeOffset.UtcNow;
        var startDate = new DateTime(eventEntity.FromDate.Year, eventEntity.FromDate.Month, 1);
        var endDate = eventEntity.ToDate > timeNow 
            ? new DateTime(timeNow.Year, timeNow.Month, 1)
            : new DateTime(eventEntity.ToDate.Year, eventEntity.ToDate.Month, 1);
        foreach (var day in startDate.EachMonthUntil(endDate))
        {
            if (!soldTicketPerMonth.Any(st => st.DateTime == day))
            {
                soldTicketPerMonth.Add(new ChartSpotDto()
                {
                    DateTime = day,
                    Count = 0,
                });
            }
        }

        return soldTicketPerMonth.OrderBy(st => st.DateTime).ToList();
    }

    private List<ChartSpotDto> GetCheckedInTicketsPerHour(EventEntity eventEntity)
    {
        var checkInsPerHour = eventEntity.Tickets.SelectMany(t => t.SoldTickets)
            .Where(st => st.IsCheckedIn)
            .OrderBy(st => st.Order.Created)
            .GroupBy(st => new { st.CheckInDate!.Value.Year, st.CheckInDate!.Value.Month, st.CheckInDate!.Value.Day, st.CheckInDate!.Value.Hour })
            .Select(st => new ChartSpotDto()
            {
                DateTime = new DateTime(st.Key.Year, st.Key.Month, st.Key.Day, st.Key.Hour, 0, 0),
                Count = st.Count(),
            })
            .ToList();

        if (checkInsPerHour.Count == 0)
        {
            return new List<ChartSpotDto>();
        }

        var timeNow = DateTimeOffset.UtcNow;
        var startDate = checkInsPerHour.First().DateTime;
        var endDate = eventEntity.ToDate > timeNow
            ? new DateTime(timeNow.Year, timeNow.Month, timeNow.Day, timeNow.Hour, 0, 0)
            : new DateTime(eventEntity.ToDate.Year, eventEntity.ToDate.Month, eventEntity.ToDate.Day, eventEntity.ToDate.Hour, 0, 0);
        foreach (var day in startDate.EachHourUntil(endDate))
        {
            if (!checkInsPerHour.Any(st => st.DateTime == day))
            {
                checkInsPerHour.Add(new ChartSpotDto()
                {
                    DateTime = day,
                    Count = 0,
                });
            }
        }

        return checkInsPerHour.OrderBy(st => st.DateTime).ToList();
    }

    private List<ChartSpotDto> GetCheckedInTicketsPerDay(EventEntity eventEntity)
    {
        var checkInsPerDay = eventEntity.Tickets.SelectMany(t => t.SoldTickets)
            .Where(st => st.IsCheckedIn)
            .OrderBy(st => st.Order.Created)
            .GroupBy(st => new { st.CheckInDate!.Value.Year, st.CheckInDate!.Value.Month, st.CheckInDate!.Value.Day })
            .Select(st => new ChartSpotDto()
            {
                DateTime = new DateTime(st.Key.Year, st.Key.Month, st.Key.Day),
                Count = st.Count(),
            })
            .ToList();

        if (checkInsPerDay.Count == 0)
        {
            return new List<ChartSpotDto>();
        }

        var timeNow = DateTimeOffset.UtcNow;
        var startDate = checkInsPerDay.First().DateTime;
        var endDate = eventEntity.ToDate > timeNow
            ? new DateTime(timeNow.Year, timeNow.Month, timeNow.Day)
            : new DateTime(eventEntity.ToDate.Year, eventEntity.ToDate.Month, eventEntity.ToDate.Day);
        foreach (var day in startDate.EachDayUntil(endDate))
        {
            if (!checkInsPerDay.Any(st => st.DateTime == day))
            {
                checkInsPerDay.Add(new ChartSpotDto()
                {
                    DateTime = day,
                    Count = 0,
                });
            }
        }

        return checkInsPerDay.OrderBy(st => st.DateTime).ToList();
    }
}
