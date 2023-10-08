using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class EditOrganizationCommandValidator : AbstractValidator<EditOrganizationCommand>
{
    public EditOrganizationCommandValidator()
    {
        RuleFor(x => x.OrganizationId)
            .NotEmpty();
        RuleFor(x => x.Description)
            .MaximumLength(256);
    }
}
