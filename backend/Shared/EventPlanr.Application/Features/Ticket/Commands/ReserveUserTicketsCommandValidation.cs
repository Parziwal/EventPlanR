using EventPlanr.Application.Models.Ticket;
using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Commands;

public class ReserveUserTicketsCommandValidation : AbstractValidator<ReserveUserTicketsCommand>
{
    public ReserveUserTicketsCommandValidation()
    {
        RuleFor(x => x.ReserveTickets)
            .Must(x => x.Count > 0)
            .WithMessage("Minimum one ticket is required");
        RuleForEach(x => x.ReserveTickets)
            .SetValidator(new AddReserveTicketDtoValidator());
        RuleFor(x => x.ReserveTickets)
            .Must(IsTicketIdUnique)
            .WithMessage("Ticket id must be unique");
    }

    public bool IsTicketIdUnique(ReserveUserTicketsCommand root, List<AddReserveTicketDto> list)
    {
        return list.All(l1 => list.Where(l2 => l2.TicketId == l1.TicketId).Count() == 1);
    }
}
