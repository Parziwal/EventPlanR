using FluentValidation;

namespace EventPlanr.Application.Features.Order.Commands;

public class RefundOrderTicketsCommandValidator : AbstractValidator<RefundOrderTicketsCommand>
{
    public RefundOrderTicketsCommandValidator()
    {
        RuleFor(x => x.OrderId)
            .NotEmpty();
    }
}
