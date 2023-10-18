using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class RemoveMemberFromUserOrganizationCommandValidator : AbstractValidator<RemoveMemberFromUserOrganizationCommand>
{
    public RemoveMemberFromUserOrganizationCommandValidator()
    {
        RuleFor(x => x.MemberUserId)
            .NotEmpty();
    }
}
