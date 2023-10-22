using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.NewsPost.Queries;

public class GetEventNewsPostQueryValidator : AbstractValidator<GetEventNewsPostQuery>
{
    public GetEventNewsPostQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
        Include(new PageDtoValidator());
    }
}
