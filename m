Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7ED1ACEAC;
	Wed, 19 Mar 2025 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394057; cv=none; b=H5KnFZCOCHn/QYZF0uy5ZUTMBmXtX/9E2k+ZG1FvA0ItRazMm2pQ+NOjTJ8vY0ikaPF69i7JbaXwG/yBxz01tBEsfkeifjsRIpVh99j9ksqcwkO/cDQuIilYdNq/LmMmxoeFog/Xg7wUpxPyOqbo+XwV58uoWGoY1V1pAfSVdks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394057; c=relaxed/simple;
	bh=DUaXuiUGOTDxDQXIAgb9Uvf/UOmBzCsQcUckAdjyriY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fufccmicKa2S1mGUf1yfRmid78Djg6cs2iNUR4CKI1zWH+QwDrJ9NggY7DffbHwnYfD3xHUnAh90yc+Ab8RDbPpXPx3624rGVbZHqEALMlRJX2SX563oSer/WMznUFez4hARcZZVXWsdUVkET/0ysMCrFQ5wExMzY5lkrbZDOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2R8SwkC4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2R8SwkC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4CEC4CEE4;
	Wed, 19 Mar 2025 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394056;
	bh=DUaXuiUGOTDxDQXIAgb9Uvf/UOmBzCsQcUckAdjyriY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2R8SwkC4WYWXgcVbhVlw1pWXFZkCXpLFQL7xGBbor4oUFUqlYpuVjuGRwiD1+CTJB
	 hqDgSHlPK4duLgaV1ybeUh2cGjfkoMeKBpidgikjb4kI/V5gsNVvEfALqECf/pk03k
	 vJrNu2vvLclODAcR5XYZdeehABMPgY6MSbbPTSUg=
Date: Wed, 19 Mar 2025 07:19:36 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Howells <dhowells@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] fs/netfs/read_collect: add to next->prev_donated
Message-ID: <2025031927-fanning-mobile-133b@gregkh>
References: <20250220152450.1075727-1-max.kellermann@ionos.com>
 <2110405.1742205792@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2110405.1742205792@warthog.procyon.org.uk>

On Mon, Mar 17, 2025 at 10:03:12AM +0000, David Howells wrote:
> Hi Greg,
> 
> Could you pick this up for 6.12.y and 6.13.y?
> 
> https://lore.kernel.org/netfs/20250220152450.1075727-1-max.kellermann@ionos.com/

Oops, missed this, sorry, now queued up.

greg k-h
