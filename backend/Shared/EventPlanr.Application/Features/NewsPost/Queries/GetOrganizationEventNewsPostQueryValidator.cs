using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.NewsPost.Queries;

public class GetOrganizationEventNewsPostQueryValidator : AbstractValidator<GetOrganizationEventNewsPostQuery>
{
    public GetOrganizationEventNewsPostQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
        Include(new PageDtoValidator());
    }
}
