﻿using EventPlanr.Application.Dto.Common;
using EventPlanr.Application.Extensions;
using EventPlanr.Domain.Exceptions;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.ComponentModel;
using System.Linq.Expressions;

namespace EventPlanr.Application.Extensions;

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

    public static async Task<PaginatedListDto<TSource>> ToPaginatedListAsync<TSource>(
        this IQueryable<TSource> source,
        PageDataDto page)
    {
        var count = await source.CountAsync();
        var items = await source.Skip((page.PageNumber - 1) * page.PageSize).Take(page.PageSize).ToListAsync();

        return new PaginatedListDto<TSource>(items, count, page.PageNumber, page.PageSize);
    }

    public static IQueryable<TSource> OrderBy<TSource, TKey>(
        this IQueryable<TSource> source,
        PageDataDto page,
        Expression<Func<TSource, TKey>> defaultOrder,
        OrderDirection defaultOrderDirection = OrderDirection.Ascending)
    {
        var orderExpression = defaultOrder;
        if (page.OrderBy != null)
        {
            var parameter = Expression.Parameter(typeof(TSource));
            var property = Expression.Property(parameter, page.OrderBy);
            var propAsObject = Expression.Convert(property, typeof(TKey));

            if (propAsObject != null)
            {
                orderExpression = Expression.Lambda<Func<TSource, TKey>>(propAsObject, parameter);
            }
        }

        var orderDirection = page.OrderDirection ?? defaultOrderDirection;
        if (orderDirection == OrderDirection.Ascending)
        {
            return source.OrderBy(orderExpression);
        }
        else
        {
            return source.OrderByDescending(orderExpression);
        }
    }
}
