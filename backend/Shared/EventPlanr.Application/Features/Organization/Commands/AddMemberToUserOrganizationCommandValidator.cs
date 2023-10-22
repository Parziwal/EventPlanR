using EventPlanr.Application.Models.Organization;
using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class AddMemberToUserOrganizationCommandValidator : AbstractValidator<AddMemberToUserOrganizationCommand>
{
    public AddMemberToUserOrganizationCommandValidator()
    {
        RuleFor(x => x.MemberUserEmail)
            .NotEmpty();
        RuleFor(x => x.Policies)
            .SetValidator(new OrganizationPoliciesValidator());
    }
}
