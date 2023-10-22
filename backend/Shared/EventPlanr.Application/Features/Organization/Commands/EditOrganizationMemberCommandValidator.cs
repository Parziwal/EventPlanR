using EventPlanr.Application.Models.Organization;
using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class EditOrganizationMemberCommandValidator : AbstractValidator<EditOrganizationMemberCommand>
{
    public EditOrganizationMemberCommandValidator()
    {
        RuleFor(x => x.MemberUserId)
            .NotEmpty();
        RuleFor(x => x.Policies)
            .SetValidator(new OrganizationPoliciesValidator());
    }
}
