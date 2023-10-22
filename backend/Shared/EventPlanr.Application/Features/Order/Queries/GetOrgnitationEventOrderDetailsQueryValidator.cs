using FluentValidation;

namespace EventPlanr.Application.Features.Order.Queries;

public class GetOrgnitationEventOrderDetailsQueryValidator : AbstractValidator<GetOrgnitationEventOrderDetailsQuery>
{
    public GetOrgnitationEventOrderDetailsQueryValidator()
    {
        RuleFor(x => x.OrderId)
            .NotEmpty();
    }
}
