using EventPlanr.Application.Models.Order;
using EventPlanr.Application.Resources;
using FluentValidation;

namespace EventPlanr.Application.Features.Order.Commands;

public class ReserveUserTicketsCommandValidation : AbstractValidator<ReserveUserTicketsCommand>
{
    public ReserveUserTicketsCommandValidation()
    {
        RuleFor(x => x.ReserveTickets)
            .Must(x => x.Count > 0 && x.Count <= 10)
            .WithMessage(LocalizerManager.Localizer["MinimumOneMaximumTenTicketAllowed"]);
        RuleForEach(x => x.ReserveTickets)
            .SetValidator(new AddReserveTicketDtoValidator());
        RuleFor(x => x.ReserveTickets)
            .Must(IsTicketIdUnique)
            .WithMessage(LocalizerManager.Localizer["TicketIdMustBeUnique"]);
    }

    public bool IsTicketIdUnique(ReserveUserTicketsCommand root, List<AddReserveTicketDto> list)
    {
        return list.All(l1 => list.Where(l2 => l2.TicketId == l1.TicketId).Count() == 1);
    }
}
