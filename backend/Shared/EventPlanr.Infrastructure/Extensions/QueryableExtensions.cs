using EventPlanr.Domain.Exceptions;
using EventPlanr.Domain.Repositories.Models;
using EventPlanr.Infrastructure.Extensions;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace EventPlanr.Infrastructure.Extensions;

public static class QueryableExtensions
{
    public static IQueryable<TSource> Where<TSource>(
        this IQueryable<TSource> source,
        bool condition,
        Expression<Func<TSource, bool>> conditionTruePredicate,
        Expression<Func<TSource, bool>>? conditionFalsePredicate = null)
    {
        if (condition)
        {
            return source.Where(conditionTruePredicate);
        }
        else if (conditionFalsePredicate != null)
        {
            return source.Where(conditionFalsePredicate);
        }
        else
        {
            return source;
        }
    }

    public static async Task<TSource> SingleEntityAsync<TSource>(
        this IQueryable<TSource> source,
        Expression<Func<TSource, bool>> predicate,
        Guid? entityId = null,
        CancellationToken cancellationToken = default)
    {
        return await source.SingleOrDefaultAsync(predicate, cancellationToken)
            ?? throw EntityNotFoundException.CreateForType<TSource>(entityId);
    }

    public static async Task<PaginatedList<TSource>> ToPaginatedListAsync<TSource>(
        this IQueryable<TSource> source,
        PageData page)
    {
        var count = await source.CountAsync();
        var items = await source.Skip((page.PageNumber - 1) * page.PageSize).Take(page.PageSize).ToListAsync();

        return new PaginatedList<TSource>(items, count, page.PageNumber, page.PageSize);
    }
}
