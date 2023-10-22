using EventPlanr.Domain.Constants;
using FluentValidation;

namespace EventPlanr.Application.Models.Organization;

public class OrganizationPoliciesValidator : AbstractValidator<List<string>>
{
    public OrganizationPoliciesValidator()
    {
        RuleFor(x => x)
            .Must(PoliciesValidator)
            .WithErrorCode("InvalidPolicy");
    }

    private bool PoliciesValidator(List<string> policies)
    {
        var inPolicies = policies.All(p => p == OrganizationPolicies.OrganizationView
            || p == OrganizationPolicies.OrganizationManage
            || p == OrganizationPolicies.OrganizationEventView
            || p == OrganizationPolicies.OrganizationEventManage
            || p == OrganizationPolicies.EventTicketView
            || p == OrganizationPolicies.EventTicketManage
            || p == OrganizationPolicies.NewsPostView
            || p == OrganizationPolicies.NewsPostManage
            || p == OrganizationPolicies.UserCheckIn);
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
        if (!policies.Contains(OrganizationPolicies.OrganizationEventView) &&
            policies.Any(p => p == OrganizationPolicies.EventTicketView
            || p == OrganizationPolicies.EventTicketManage
            || p == OrganizationPolicies.NewsPostView
            || p == OrganizationPolicies.NewsPostManage
            || p == OrganizationPolicies.UserCheckIn))
        {
            return false;
        }

        return true;
    }
}
