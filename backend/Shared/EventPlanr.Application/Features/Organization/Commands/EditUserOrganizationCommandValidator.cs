using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class EditUserOrganizationCommandValidator : AbstractValidator<EditUserOrganizationCommand>
{
    public EditUserOrganizationCommandValidator()
    {
        RuleFor(x => x.Description)
            .MaximumLength(256);
    }
}
