using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Invitation;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using MediatR;

namespace EventPlanr.Application.Features.Invitation.Queries;

[Authorize(OrganizationPolicy = OrganizationPolicies.InvitationView)]
public class GetOrganizationEventInvitationsQuery : PageDto, IRequest<PaginatedListDto<EventInvitationDto>>
{
    public Guid EventId { get; set; }
}

public class GetOrganizationEventInvitationsQueryHandler : IRequestHandler<GetOrganizationEventInvitationsQuery, PaginatedListDto<EventInvitationDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;
    private readonly IUserService _userService;

    public GetOrganizationEventInvitationsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper,
        IUserService userService)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
        _userService = userService;
    }

    public async Task<PaginatedListDto<EventInvitationDto>> Handle(GetOrganizationEventInvitationsQuery request, CancellationToken cancellationToken)
    {
        var invitations = await _dbContext.Invitations
            .Where(i => i.EventId == request.EventId && i.Event.OrganizationId == _user.OrganizationId)
            .OrderByDescending(i => i.Created)
            .ToPaginatedListAsync(request);

        var users = new Dictionary<Guid, UserEntity>();
        foreach (var invitation in invitations.Items)
        {
            var user = await _userService.GetUserById(invitation.UserId);
            users.Add(user!.Id, user);
        }

        return new PaginatedListDto<EventInvitationDto>() {
            Items = invitations.Items.Select(i =>
            {
                var mappedInvitation = _mapper.Map<EventInvitationDto>(i);
                var user = users[i.UserId];
                mappedInvitation.UserFirstName = user.FirstName;
                mappedInvitation.UserLastName = user.LastName;

                return mappedInvitation;
            }).ToList(),
            PageNumber = invitations.PageNumber,
            TotalCount = invitations.TotalCount,
            TotalPages = invitations.TotalPages,
        };
    }
}