using EventPlanr.Application.Models.Common;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Commands;

public class EditEventCommandValidator : AbstractValidator<EditEventCommand>
{
    public EditEventCommandValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
        RuleFor(x => x.Category)
            .IsInEnum();
        RuleFor(x => x.Currency)
            .IsInEnum();
        RuleFor(x => x.FromDate)
            .Must((fields, fromDate) => fromDate <= fields.ToDate)
            .WithErrorCode("FromDateMustBeBeforeToDate")
            .Must(x => x > DateTimeOffset.UtcNow)
            .WithErrorCode("FromDateMustBeBeforeCurrentDate");
        RuleFor(x => x.ToDate)
            .Must((fields, toDate) => toDate >= fields.FromDate)
            .WithErrorCode("ToDateMustBeAfterFromDate");
        RuleFor(x => x.Venue)
            .MaximumLength(64)
            .NotEmpty();
        RuleFor(x => x.Address)
            .SetValidator(new AddressDtoValidator());
        RuleFor(x => x.Coordinate)
            .SetValidator(new CoordinateDtoValidator());
        RuleFor(x => x.IsPrivate)
            .NotNull();
    }
}
