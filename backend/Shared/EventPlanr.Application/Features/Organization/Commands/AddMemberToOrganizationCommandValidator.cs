using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class AddMemberToOrganizationCommandValidator : AbstractValidator<AddMemberToOrganizationCommand>
{
    public AddMemberToOrganizationCommandValidator()
    {
        RuleFor(x => x.UserEmail)
            .NotEmpty();
    }
}
