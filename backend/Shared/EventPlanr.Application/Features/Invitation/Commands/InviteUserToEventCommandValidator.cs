using FluentValidation;

namespace EventPlanr.Application.Features.Invitation.Commands;

public class InviteUserToEventCommandValidator : AbstractValidator<InviteUserToEventCommand>
{
    public InviteUserToEventCommandValidator()
    {
        RuleFor(x => x.UserEmail)
            .EmailAddress();
    }
}
