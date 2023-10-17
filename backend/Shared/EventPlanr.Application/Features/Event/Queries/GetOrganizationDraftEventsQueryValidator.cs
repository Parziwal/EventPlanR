using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetOrganizationDraftEventsQueryValidator : AbstractValidator<GetOrganizationDraftEventsQuery>
{
    public GetOrganizationDraftEventsQueryValidator()
    {
        Include(new PageDtoValidator());
    }
}
