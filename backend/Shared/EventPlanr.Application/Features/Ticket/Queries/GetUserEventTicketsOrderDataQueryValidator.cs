using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Queries;

public class GetUserEventTicketsOrderDataQueryValidator : AbstractValidator<GetUserEventTicketsOrderDataQuery>
{
    public GetUserEventTicketsOrderDataQueryValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
