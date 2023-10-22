using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Commands;

public class EditTicketCommandValidator : AbstractValidator<EditTicketCommand>
{
    public EditTicketCommandValidator()
    {
        RuleFor(x => x.TicketId)
            .NotEmpty();
        RuleFor(x => x.Price)
            .GreaterThanOrEqualTo(0)
            .NotNull();
        RuleFor(x => x.Count)
            .GreaterThan(0)
            .NotNull();
        RuleFor(x => x.Description)
            .MaximumLength(256);
        RuleFor(x => x.SaleStarts)
            .Must((fields, saleStarts) => saleStarts <= fields.SaleEnds)
            .WithMessage("SaleStarts must be before SaleEnds.")
            .NotNull();
        RuleFor(x => x.SaleEnds)
            .Must((fields, saleEnds) => saleEnds >= fields.SaleStarts)
            .WithMessage("SaleEnds must be after SaleStarts.")
            .NotNull();
    }
}
