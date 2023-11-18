using FluentValidation;

namespace EventPlanr.Application.Features.Invitation.Queries;

public class GetUserEventInvitationQueryValidator : AbstractValidator<GetUserEventInvitationQuery>
{
    public GetUserEventInvitationQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotNull();
    }
}
