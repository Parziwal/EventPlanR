using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetOrganizationEventStatisticsQueryValidator : AbstractValidator<GetOrganizationEventStatisticsQuery>
{
    public GetOrganizationEventStatisticsQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
