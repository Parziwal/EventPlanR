using MediatR;

public record GetUserEventIdsQuery(string userId) : IRequest<List<string>>;
