Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB41D63D3
	for <netfs@lists.linux.dev>; Mon,  3 Feb 2025 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605678; cv=none; b=mN9aCAbx6tGbuc+FFehfR+rJzP4Z+kgzT8SdOnAyyJYIWeWQlXxPVVQtNzOQ5qOKqQx3eQHFTWal8VLx+t9vQCdaWMu7/8eaD/AXUG76pny8TG8dsqmzkAIO4aEDJy+te5jvXgsXmSNSXTWjDC9amu+Ryq86zDvjZJ9ox+ftBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605678; c=relaxed/simple;
	bh=iVzkS+UvCFYYeZQR+44TT1VsP//ByWueNSPjiUEP1zc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bQANoMePJfnz+dIdfK1dXMxABBTQcY7woMjPEV2eHwze+kqLIh47NmGyxRgLcxJGmkHlAlYaH9U21YjExqnAVtvhLBMqfhU6+Au2wazmgAmyS1k/WIwEccmzHhm9VDpLAmNxKchYBbzdrEE8aCU2xI3l4ZufS+Bn+hnK3JusW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QFDqLwM5; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QFDqLwM5"
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738605669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVzkS+UvCFYYeZQR+44TT1VsP//ByWueNSPjiUEP1zc=;
	b=QFDqLwM5revA9ovdbD5YThoHNMIef2ZRejuQsAxZmDhc5QygWfkKMs1XkXhy/ZwdqR7uma
	PfhyxdcR2QBwJHfdPNQxnG1G+oz79guTdHxhtLM5lM0eLZYveJJ4GTdu2GvaMLDA6t1bwl
	bdBYGXoi36nq1f/PNnsQ15sUL2hbg5Q=
Date: Mon, 03 Feb 2025 18:01:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <8fdc14d72d9c43867e31d620945b46aad035515e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] netfs: Add retry stat counters
To: "David Howells" <dhowells@redhat.com>, "Marc Dionne"
 <marc.dionne@auristor.com>, "Steve French" <stfrench@microsoft.com>
Cc: dhowells@redhat.com, "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>, "Dominique Martinet"
 <asmadeus@codewreck.org>, "Christian Schoenebeck"
 <linux_oss@crudebyte.com>, "Paulo Alcantara" <pc@manguebit.com>, "Jeff 
 Layton" <jlayton@kernel.org>, "Christian Brauner" <brauner@kernel.org>,
 v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, bpf@vger.kernel.org
In-Reply-To: <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev>
References: <3173328.1738024385@warthog.procyon.org.uk>
 <3187377.1738056789@warthog.procyon.org.uk>
 <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev>
X-Migadu-Flow: FLOW_OUT

On 1/28/25 11:11 AM, Ihor Solodrai wrote:
> January 28, 2025 at 1:33 AM, "David Howells" <dhowells@redhat.com> wrot=
e:
>
>> Here's an additional patch to allow stats on the number of retries to =
be
>> obtained. This isn't a fix per se.
>> David
>>
>> [...]
>
> Hi David, Marc.
>
> I regret to report that this patch didn't fix the hanging in
> v9fs_evict_inode when running selftests/bpf.

David, Marc,

Were you able to reproduce the hanging?

We're still using the revert of the original patch [1] in BPF CI as a
mitigation.

If there is other pending work that may be relevant, please share.

Thanks.

[1] https://lore.kernel.org/all/20241216204124.3752367-28-dhowells@redhat=
.com/

>
> [...]
