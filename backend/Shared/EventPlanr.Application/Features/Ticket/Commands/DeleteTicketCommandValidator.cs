using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Commands;

public class DeleteTicketCommandValidator : AbstractValidator<DeleteTicketCommand>
{
    public DeleteTicketCommandValidator()
    {
        RuleFor(x => x.TicketId)
            .NotEmpty();
    }
}
