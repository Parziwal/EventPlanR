using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Invitation.Queries;

public class GetOrganizationEventInvitationsQueryValidator : AbstractValidator<GetOrganizationEventInvitationsQuery>
{
    public GetOrganizationEventInvitationsQueryValidator()
    {
        Include(new PageDtoValidator());
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
