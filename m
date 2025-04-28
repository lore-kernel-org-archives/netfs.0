Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B726988C
	for <netfs@lists.linux.dev>; Mon, 28 Apr 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847526; cv=none; b=M4yQB8nkdciRvwXbkMP4vem4nnJ9B7wofdtan4xjtbgIq9CS8cuvYmu6MOlnXNFe+OcRB8qydPZkpc/BRYEJBClY9yiP8xUqp41wxRjzsxurvtT5ILpdOVs53L8WxEZEKsRaX07Vx3NhrNyItqUUcoAz/TBsseO1UnBKOqkqq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847526; c=relaxed/simple;
	bh=qQFyVti48/QNS9uXHnqXQI3AgYrjAJyezqJWtH1sdzk=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=dG52JYrUjXzMBD4lCwSMzttedCaDyEPM6r0Pno4ZRROanwI/DitJQWJm2AGiA4AQzVrNanl/gau7ECTgQU+QNCXqKLIaAsheklk5Tx3evpmp/ck2Vf4oSmy4ccSDq9K6bGMr7ZII5tI8EK+EiSRQDO5h9jQiotwxNUWlbPj/iko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=NxQikjTa; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="NxQikjTa"
Message-ID: <a83bf0565fccbe448ab1a350def86f91@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1745847523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nnb2PBo8ZO1TcHVs62W9HZZ+CzPyOuSJ0EVp+DituY=;
	b=NxQikjTaSsKUWIKOEI/u6ALDGyv3qhLQD2G/jdMvJhR9RjnJFYIXfMeDgMyc1DqdPRSkmE
	hoRYVNUuEIjVJm4lVTq6UHjcy5TRJ9FkW+zrQ2lFJha9gHowgKSvJ/88m52gEn20bEpcQo
	plXUNqjJVJUKNIjRpksEYd9I3TzD9JJ6Q2l49W7DsjEtdfbTyRa4n4BqsKFw9BSSqKdpIa
	GFl+EA0TDkG+/OgyYDWXHk2h3c+a3spH4BslhUtVzhuBALu6IjQ57TC+/+ym91E3U8K7hd
	cWsHkN1/Uk6J8z+7QMGp7o1c2ZkG6hNHGIDGdPa9gun8TkrtMv8jb95mF4vDpg==
From: Paulo Alcantara <pc@manguebit.com>
To: Max Kellermann <max.kellermann@ionos.com>, dhowells@redhat.com,
 netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH] fs/netfs/read_collect: remove duplicate line
In-Reply-To: <notmuch-sha1-fe1ebcd5fc23eab1dc1cf15f4369d4b0ea567ded>
References: <20250428114842.3180169-1-max.kellermann@ionos.com>
Date: Mon, 28 Apr 2025 10:38:39 -0300
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Paulo Alcantara <pc@manguebit.com> writes:

> Max Kellermann <max.kellermann@ionos.com> writes:
>
>> @@ -653,7 +653,6 @@ ssize_t netfs_wait_for_read(struct netfs_io_request *rreq)
>>  		switch (rreq->origin) {
>>  		case NETFS_DIO_READ:
>>  		case NETFS_READ_SINGLE:
>> -			ret = rreq->transferred;
>>  			break;
>>  		default:
>>  			if (rreq->submitted < rreq->len) {
>
> This is wrong.  @ret is expected to have the amount of bytes
> successfully read if no error.

Err, sorry.  I just saw the assignment right after if (ret == 0) check.

Looks good,

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
