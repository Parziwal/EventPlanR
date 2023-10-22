using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Commands;

public class RefundTicketCommandValidator : AbstractValidator<RefundTicketCommand>
{
    public RefundTicketCommandValidator()
    {
        RuleFor(x => x.SoldTicketId)
            .NotEmpty();
    }
}
