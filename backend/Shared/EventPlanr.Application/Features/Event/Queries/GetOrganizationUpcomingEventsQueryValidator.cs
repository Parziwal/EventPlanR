using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetOrganizationUpcomingEventsQueryValidator : AbstractValidator<GetOrganizationUpcomingEventsQuery>
{
    public GetOrganizationUpcomingEventsQueryValidator()
    {
        Include(new PageDtoValidator());
    }
}
