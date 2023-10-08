using FluentValidation;

namespace EventPlanr.Application.Features.User.Queries;

public class GetUserClaimQueryValidator : AbstractValidator<GetUserClaimQuery>
{
    public GetUserClaimQueryValidator()
    {
        RuleFor(x => x.UserId)
            .NotEmpty();
    }
}
