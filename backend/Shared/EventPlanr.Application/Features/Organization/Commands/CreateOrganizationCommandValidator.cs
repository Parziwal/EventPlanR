using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class CreateOrganizationCommandValidator : AbstractValidator<CreateOrganizationCommand>
{
    public CreateOrganizationCommandValidator()
    {
        RuleFor(x => x.Name)
            .MaximumLength(64)
            .NotEmpty();
        RuleFor(x => x.Description)
            .MaximumLength(254);
    }
}
