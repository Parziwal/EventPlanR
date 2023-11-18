using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Models.Ticket;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Event;

public class EventStatisticsDto
{
    public double TotalIncome { get; set; }
    public Currency Currency { get; set; }
    public int TotalTicketCount { get; set; }
    public int SoldTicketCount { get; set; }
    public List<ChartSpotDto> SoldTicketsPerDay { get; set; } = new List<ChartSpotDto>();
    public List<ChartSpotDto> SoldTicketsPerMonth { get; set; } = new List<ChartSpotDto>();
    public List<TicketStatisticsDto> TicketStatistics { get; set; } = new List<TicketStatisticsDto>();
    public int TotalCheckInCount { get; set; }
    public List<ChartSpotDto> CheckInsPerHour { get; set; } = new List<ChartSpotDto>();
    public List<ChartSpotDto> CheckInsPerDay { get; set; } = new List<ChartSpotDto>();
    public int TotalInvitationCount { get; set; }
    public int AcceptedInvitationCount { get; set; }
    public int DeniedInvitationCount { get; set; }
    public int PendingInvitationCount { get; set; }
}
