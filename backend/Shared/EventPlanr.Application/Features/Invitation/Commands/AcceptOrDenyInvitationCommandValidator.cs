using FluentValidation;

namespace EventPlanr.Application.Features.Invitation.Commands;

public class AcceptOrDenyInvitationCommandValidator : AbstractValidator<AcceptOrDenyInvitationCommand>
{
    public AcceptOrDenyInvitationCommandValidator()
    {
        RuleFor(x => x.InvitationId)
            .NotEmpty();
    }
}
