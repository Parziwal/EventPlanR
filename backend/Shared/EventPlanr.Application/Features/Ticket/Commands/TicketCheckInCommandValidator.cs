using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Commands;

public class TicketCheckInCommandValidator : AbstractValidator<TicketCheckInCommand>
{
    public TicketCheckInCommandValidator()
    {
        RuleFor(x => x.SoldTicketId)
            .NotEmpty();
        RuleFor(x => x.CheckIn);
    }
}
