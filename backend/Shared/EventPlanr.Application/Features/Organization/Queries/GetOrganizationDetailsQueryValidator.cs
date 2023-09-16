using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Queries;

public class GetOrganizationDetailsQueryValidator : AbstractValidator<GetOrganizationDetailsQuery>
{
    public GetOrganizationDetailsQueryValidator()
    {
        RuleFor(x => x.OrganizationId)
            .NotNull();
    }
}
