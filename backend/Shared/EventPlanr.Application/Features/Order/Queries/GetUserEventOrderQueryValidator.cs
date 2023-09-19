using FluentValidation;

namespace EventPlanr.Application.Features.Order.Queries;

public class GetUserEventOrderQueryValidator : AbstractValidator<GetUserEventOrderQuery>
{
    public GetUserEventOrderQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
