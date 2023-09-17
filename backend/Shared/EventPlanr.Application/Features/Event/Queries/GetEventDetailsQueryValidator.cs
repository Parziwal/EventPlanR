using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetEventDetailsQueryValidator : AbstractValidator<GetEventDetailsQuery>
{
    public GetEventDetailsQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
