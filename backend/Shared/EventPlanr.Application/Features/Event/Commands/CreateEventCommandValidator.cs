using EventPlanr.Application.Models.Common;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Commands;

public class CreateEventCommandValidator : AbstractValidator<CreateEventCommand>
{
    public CreateEventCommandValidator()
    {
        RuleFor(x => x.Name)
            .MaximumLength(64)
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
        RuleFor(x => x.Coordinates)
            .SetValidator(new CoordinatesDtoValidator());
        RuleFor(x => x.IsPrivate)
            .NotNull();
    }
}
