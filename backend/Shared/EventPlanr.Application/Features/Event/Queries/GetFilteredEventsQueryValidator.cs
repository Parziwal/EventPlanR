using EventPlanr.Application.Dto.Common;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetFilteredEventsQueryValidator : AbstractValidator<GetFilteredEventsQuery>
{
    public GetFilteredEventsQueryValidator()
    {
        Include(new PageDataDtoValidator());
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
        RuleFor(x => x.Location)
            .SetValidator(new LocationDtoValidator()!);
    }
}
