using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Models.Ticket;
using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Commands;

public class OrderReservedTicketsCommandValidator : AbstractValidator<OrderReservedTicketsCommand>
{
    public OrderReservedTicketsCommandValidator()
    {
        RuleFor(x => x.CustomerFirstName)
            .MaximumLength(64)
            .NotEmpty();
        RuleFor(x => x.CustomerLastName)
            .MaximumLength(64)
            .NotEmpty();
        RuleFor(x => x.BillingAddress)
            .SetValidator(new AddressDtoValidator());
        RuleFor(x => x.TicketUserInfos)
            .Must(x => x.Count > 0)
            .WithMessage("Minimum one ticket info is required");
        RuleForEach(x => x.TicketUserInfos)
            .SetValidator(new AddTicketUserInfoDtoValidator());
    }
}
