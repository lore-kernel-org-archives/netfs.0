Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8363021ABDF
	for <netfs@lists.linux.dev>; Tue, 25 Feb 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522965; cv=none; b=Q6XdZgwY0dX0AGjPw/N2JaU2yXvjLWrwWqmdViNGdRTHH0pUSvUBBhgK8PBVkbC2oljAuLe3akmoJkJx8kGvJ62gdlN9Ndzz17mq67svVhq6xex2ZQJ2+7GAU/JHrX+VxQt+Ql/2o2ph8BK6dMWBHt8WcBt59Y5B/1m4Ez8tuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522965; c=relaxed/simple;
	bh=LId8wARo8fFkuaheKwyZhfKVheDRdazKR+fWXvZKTSs=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=iEXJrauYivDPHCuB0RlpAhe4lg5ahlAf3B1wZxxvrOy+DxTfivWSiqEODrPHiTROcyuIfaLFzIPgti0h40pCOWC9yFn1DfYcTTZfCPTqI1sArz40BrT4YKTCZGb/TkCcxt8VT0uDdzHm+y9B+RXEoTAyDhMRItXWZ1j84hbww+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=dlV0iDsD; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="dlV0iDsD"
Message-ID: <3c4f7265522cb15334aa90cbccdd4733@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1740522954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zvzu9AxG+G7+SM5+BrgtHqFH4W8oArTOexyK6oANXA=;
	b=dlV0iDsDsOcl/HOA4JBhfDjARmCfDUfgWA7urfsKG2sdauhTUhYapj8M1M9JJlQiFFwx18
	BXt2eZuzHCiO6E4m2JrfAwspRaLtH85uzE8OzJl8/M8RM9r6r2zVwchwwk3O2U9ZiBs0rX
	73IRwcmvY+Y+dvDfRoGYIDhj2jUdneYGy7phUJOwZOd39ZVgYDO4rQWUyP6oqOhuKxd09+
	sRhIq0kx7rK7N+bHlPPPg3atMgMvuSqVhYAlZZ5sjnWOSBWu8+70xDzLUrpWL5SDRwwiCT
	wU+eLyElL0GmnM1/5kRBWYzMY9+keTpcmKfMUmEY1zk9QgNyQw6G8FOla8AUdA==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Steve French
 <stfrench@microsoft.com>, Jean-Christophe Guillain
 <jean-christophe@guillain.net>
Cc: dhowells@redhat.com, Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>, Jeff
 Layton
 <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix the smb1 readv callback to correctly call netfs
In-Reply-To: <2433838.1740522300@warthog.procyon.org.uk>
References: <2433838.1740522300@warthog.procyon.org.uk>
Date: Tue, 25 Feb 2025 19:35:50 -0300
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Howells <dhowells@redhat.com> writes:

>=20=20=20=20=20
> Fix cifs_readv_callback() to call netfs_read_subreq_terminated() rather
> than queuing the subrequest work item (which is unset).  Also call the
> I/O progress tracepoint.
>
> Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use=
 one work item")
> Reported-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219793
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Pali Roh=C3=A1r <pali@kernel.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/cifssmb.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
