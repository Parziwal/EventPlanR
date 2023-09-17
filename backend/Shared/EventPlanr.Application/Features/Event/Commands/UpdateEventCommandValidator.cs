using EventPlanr.Application.Models.Common;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Commands;

public class UpdateEventCommandValidator : AbstractValidator<UpdateEventCommand>
{
    public UpdateEventCommandValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
        RuleFor(x => x.Category)
            .IsInEnum();
        RuleFor(x => x.Language)
            .IsInEnum();
        RuleFor(x => x.Currency)
            .IsInEnum();
        RuleFor(x => x.FromDate)
            .Must((fields, fromDate) => fromDate <= fields.ToDate)
            .WithMessage("FromDate must be before ToDate.");
        RuleFor(x => x.ToDate)
            .Must((fields, toDate) => toDate >= fields.FromDate)
            .WithMessage("ToDate must be after FromDate.");
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
