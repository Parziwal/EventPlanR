using FluentValidation;

namespace EventPlanr.Application.Models.Ticket;

public class AddReserveTicketDtoValidator : AbstractValidator<AddReserveTicketDto>
{
    public AddReserveTicketDtoValidator()
    {
        RuleFor(x => x.TicketId)
            .NotEmpty();
        RuleFor(x => x.Count)
            .GreaterThan(0)
            .LessThanOrEqualTo(10)
            .NotNull();
    }
}
