using FluentValidation;

namespace EventPlanr.Application.Features.Invitation.Commands;

public class DeleteInvitationCommandValidator : AbstractValidator<DeleteInvitationCommand>
{
    public DeleteInvitationCommandValidator()
    {
        RuleFor(x => x.InvitationId)
            .NotEmpty();
    }
}
