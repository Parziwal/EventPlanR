using EventPlanr.Application.Resources;
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
            .WithMessage(LocalizerManager.Localizer["SaleStartsMustBeBeforeSaleEnds"])
            .Must(x => x > DateTimeOffset.UtcNow)
            .WithErrorCode(LocalizerManager.Localizer["SaleStartsMustBeAfterCurrentDate"])
            .NotNull();
        RuleFor(x => x.SaleEnds)
            .Must((fields, saleEnds) => saleEnds >= fields.SaleStarts)
            .WithMessage(LocalizerManager.Localizer["SaleEndsMustBeAfterSaleStarts"])
            .NotNull();
    }
}
