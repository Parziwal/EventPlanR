using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class SetUserOrganizationCommandValidator : AbstractValidator<SetUserOrganizationCommand>
{
    public SetUserOrganizationCommandValidator()
    {
        RuleFor(x => x.OrganizationId)
            .NotEmpty();
    }
}
