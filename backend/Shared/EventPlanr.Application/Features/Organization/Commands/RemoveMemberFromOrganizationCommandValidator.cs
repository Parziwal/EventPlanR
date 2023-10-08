using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class RemoveMemberFromOrganizationCommandValidator : AbstractValidator<RemoveMemberFromOrganizationCommand>
{
    public RemoveMemberFromOrganizationCommandValidator()
    {
        RuleFor(x => x.OrganizationId)
            .NotEmpty();
        RuleFor(x => x.MemberUserId)
            .NotEmpty();
    }
}
