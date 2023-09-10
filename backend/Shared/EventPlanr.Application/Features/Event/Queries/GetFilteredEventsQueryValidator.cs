using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetFilteredEventsQueryValidator : AbstractValidator<GetFilteredEventsQuery>
{
    public GetFilteredEventsQueryValidator()
    {
        RuleFor(x => x.Category)
            .IsInEnum();
        RuleFor(x => x.Language)
            .IsInEnum();
        RuleFor(x => x.Currency)
            .IsInEnum();
        RuleFor(x => x.FromDate)
            .Must((fields, fromDate) => fromDate <= fields.ToDate)
            .When(x => x.FromDate != null && x.ToDate != null)
            .WithMessage("FromDate must be before ToDate.");
        RuleFor(x => x.ToDate)
            .Must((fields, toDate) => toDate >= fields.FromDate)
            .When(x => x.FromDate != null && x.ToDate != null)
            .WithMessage("FromDate must be before ToDate.");
        RuleFor(x => x.Latitude)
            .NotNull()
            .When(x => x.Longitude != null || x.Radius != null);
        RuleFor(x => x.Longitude)
            .NotNull()
            .When(x => x.Latitude != null || x.Radius != null);
        RuleFor(x => x.Radius)
            .NotNull()
            .When(x => x.Latitude != null || x.Longitude != null);
        RuleFor(x => x.PageNumber)
            .NotNull();
        RuleFor(x => x.PageSize)
            .NotNull();
    }
}
