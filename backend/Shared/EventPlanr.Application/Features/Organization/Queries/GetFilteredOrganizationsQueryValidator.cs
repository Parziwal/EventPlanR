using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Queries;

public class GetFilteredOrganizationsQueryValidator : AbstractValidator<GetFilteredOrganizationsQuery>
{
    public GetFilteredOrganizationsQueryValidator()
    {
        Include(new PageWithOrderDtoValidator());
    }
}
