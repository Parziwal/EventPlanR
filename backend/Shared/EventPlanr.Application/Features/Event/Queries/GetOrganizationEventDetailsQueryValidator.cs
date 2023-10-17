using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetOrganizationEventDetailsQueryValidator : AbstractValidator<GetOrganizationEventDetailsQuery>
{
    public GetOrganizationEventDetailsQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
