using EventPlanr.Domain.Constants;
using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class AddMemberToOrganizationCommandValidator : AbstractValidator<AddMemberToOrganizationCommand>
{
    public AddMemberToOrganizationCommandValidator()
    {
        RuleFor(x => x.OrganizationId)
            .NotEmpty();
        RuleFor(x => x.MemberUserEmail)
            .NotEmpty();
        RuleFor(x => x.Policies)
            .Must(x => x.All(p => p == OrganizationPolicies.OrganizationView || p == OrganizationPolicies.OrganizationManage
            || p == OrganizationPolicies.OrganizationEventView || p == OrganizationPolicies.OrganizationEventManage))
            .WithErrorCode("InvalidPolicy");
    }
}
