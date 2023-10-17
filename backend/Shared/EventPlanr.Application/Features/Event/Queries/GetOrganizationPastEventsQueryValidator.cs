using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetOrganizationPastEventsQueryValidator : AbstractValidator<GetOrganizationPastEventsQuery>
{
    public GetOrganizationPastEventsQueryValidator()
    {
        Include(new PageDtoValidator());
    }
}
