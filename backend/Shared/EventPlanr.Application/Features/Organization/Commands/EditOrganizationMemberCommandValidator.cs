using EventPlanr.Domain.Constants;
using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class EditOrganizationMemberCommandValidator : AbstractValidator<EditOrganizationMemberCommand>
{
    public EditOrganizationMemberCommandValidator()
    {
        RuleFor(x => x.MemberUserId)
            .NotEmpty();
        RuleFor(x => x.Policies)
            .Must(OrganizationPoliciesValidator)
            .WithErrorCode("InvalidPolicy");
    }

    private bool OrganizationPoliciesValidator(List<string> policies)
    {
        var inPolicies = policies.All(p => p == OrganizationPolicies.OrganizationView
            || p == OrganizationPolicies.OrganizationManage
            || p == OrganizationPolicies.OrganizationEventView
            || p == OrganizationPolicies.OrganizationEventManage);
        if (!inPolicies)
        {
            return false;
        }

        if (policies.Contains(OrganizationPolicies.OrganizationManage)
            && !policies.Contains(OrganizationPolicies.OrganizationView))
        {
            return false;
        }
        if (policies.Contains(OrganizationPolicies.OrganizationEventManage)
            && !policies.Contains(OrganizationPolicies.OrganizationEventView))
        {
            return false;
        }

        return true;
    }
}
