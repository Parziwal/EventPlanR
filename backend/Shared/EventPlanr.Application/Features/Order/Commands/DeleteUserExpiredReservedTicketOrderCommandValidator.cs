using FluentValidation;

namespace EventPlanr.Application.Features.Order.Commands;

public class DeleteUserExpiredReservedTicketOrderCommandValidator : AbstractValidator<DeleteUserExpiredReservedTicketOrderCommand>
{
    public DeleteUserExpiredReservedTicketOrderCommandValidator()
    {
        RuleFor(x => x.UserId)
            .NotEmpty();
    }
}
